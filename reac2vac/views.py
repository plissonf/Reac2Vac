from sqlalchemy import create_engine
from sqlalchemy_utils import database_exists, create_database

#%%
from flask import render_template
from flask import Flask
from flask import request
from flask import json
from reac2vac import app
#%%

import pandas as pd
import psycopg2
import pickle
import dill as pickle
import os, sys
import json



from sklearn import preprocessing
from sklearn.ensemble import RandomForestClassifier
from wtforms import Form, validators, StringField, SubmitField, IntegerField



## Connecting databases
user = 'fabienplisson'
host = 'localhost'
dbname = 'patientsdata_db2'
db = create_engine('postgres://%s%s/%s'%(user,host,dbname))
con = None
con = psycopg2.connect(database = dbname, user = user)

dbname2 = 'adverseeventsdata_db'
db2 = create_engine('postgres://%s%s/%s'%(user,host,dbname2))
con2 = None
con2 = psycopg2.connect(database = dbname2, user = user)

rfc = pickle.load(open('/Users/fabienplisson/Desktop/Insight_Data/Flask_setup/reac2vac/rfc.p', 'rb'))

## Define a route for the default URL, which loads the input file
@app.route('/')
@app.route('/input')
@app.route('/home')
def input():
    return render_template("input.html")

# Define a route for the default URL, which loads the output file
@app.route('/output')
def id():
    code = request.args.get('id_number')

    sql_query = """ SELECT * FROM patientsdata2 WHERE id_number = '%s' """ %code
    query_results = pd.read_sql_query(sql_query, con)
    query_results = pd.DataFrame(query_results)
    query_results = query_results.values[0][1:]

    the_class = rfc.predict(query_results.reshape(1, -1))[0]

    # Query the second database 'adverseeventsdata' for the corresponding class
    # And return the likelihood of matching adverse events for that class
    sql_query2 = """ SELECT * FROM adverseeventsdata ;"""
    events_results = pd.read_sql_query(sql_query2, con2)
    events_results = pd.DataFrame(events_results)
    events_results = events_results[events_results['class']==int(the_class)]

    events_result_dict = {key: str(int(value * 100)) for key, value
        in zip(events_results.columns[1:], events_results.values[0,1:])}

    keys = events_result_dict.keys()

    values = []
    for item in events_result_dict.values():
      values.append(int(item))


    return render_template("output.html", keys = keys, values = values)
