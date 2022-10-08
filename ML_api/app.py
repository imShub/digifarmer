# from lightgbm import LGBMClassifier
import joblib
import flask
from flask import request
from flask import Flask, jsonify
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np
from PIL import Image
from sklearn.ensemble import RandomForestRegressor

app = flask.Flask(__name__)
app.config["DEBUG"] = True

# @app.before_request
# def before_request_func():
#     global something

# main index page route
@app.route('/')
def home():
    return '<h1>API is working.. </h1>'

@app.route('/predict',methods=['GET'])
def predict():
    model = joblib.load('lgbm.ml')
    # model.predict([[188,1,1,0,0.0,0,1,0,0,0,1,0]])
    predict = model.predict([[int(request.args['InsectCount']),
                            int(request.args['CropType']),
                            int(request.args['SoilType']),
                            int(request.args['NDosesWeek']),
                            float(request.args['NWeeksUsed']),
                            int(request.args['NWeeksQuit']),
                            int(request.args['Pest1']),
                            int(request.args['Pest2']),
                            int(request.args['Pest3']),
                            int(request.args['Season1']),
                            int(request.args['Season2']),
                            int(request.args['Season3']),
                           ]])
    return flask.jsonify(str(predict)[1])



@app.route('/jsonPost', methods = ['POST'])
def jsonPost(uuid):
    content = request.json
    plt.rc("font", size=14)
    sns.set(style="white")
    sns.set(style="whitegrid", color_codes=True)
    df = pd.read_csv("Crop_Production_with_rainfall.csv")
    rain = pd.read_csv("Rainfall Predicted.csv")
    data = df.dropna()
    print(data.shape)
    dis=content['district']
    # input("Enter the District Name: ")
    state=list(data[data["District_Name"]==dis.upper()]["State_Name"][:1])[0]
    season=content['season']
    # input("Enter the Season: ")
    area_in=content['area']
    # input("Enter Area in hectares: ")
    s=list(data["Season"].unique())
    for x in s:
        if season.title() in x:
            sin=s.index(x)
    data_cu=data[data["District_Name"]==dis.upper()][data["Season"]==s[sin]]
    data1 = data_cu.drop(["State_Name","Crop_Year"],axis=1)
    data_dum = pd.get_dummies(data1)
    x = data_dum.drop("Production",axis=1)
    y = data_dum[["Production"]]

    model = RandomForestRegressor()
    model.fit(x,y.values.ravel())

    ch=pd.DataFrame()
    for crop in list(datacu["Crop"].unique()):
        t=(x[x["Crop{}".format(crop)]==1])[:1]
        ch=pd.concat([ch,t])
    ch["Area"]=area_in
    ch["Rainfall"]=list(rain[rain["State_Name"]==state]["Rainfall"])[0]
    predict=model.predict(ch)
    crname=data.loc[ch.index]["Crop"]
    crdata= {'Crop': list(crname), 
            'Production': list(predict)}
    crpro = pd.DataFrame(crdata) 
    crpro=crpro.sort_values(by=['Production'], ascending=False)
    print(crpro)
    crpro.plot.bar(x = 'Crop', y = 'Production')
    plt.savefig('yieldimg/output.png')
    # plt.show()
    
    print(content['district'])
    global something
    something=1
    return jsonify({"uuid":uuid})




@app.route('/dataupload',methods=['GET'])
def uploadData():
    global something
    while(True):
        if something == 1:
            break
    data = {
            "Run" : "Yes"
        }
    return jsonify(data)





if __name__ == "__main__":
    app.run(debug=True) 
