from flask import Flask,render_template,redirect,session,url_for,flash
from flask_bootstrap import Bootstrap
from flask_moment import Moment
from datetime import datetime

from flask_wtf import FlaskForm
from wtforms import StringField,SubmitField
from wtforms.validators import DataRequired

app = Flask(__name__)
app.config["SECRET_KEY"]="hard to guess string"

bootstrap = Bootstrap(app)
moment=Moment(app)

@app.route("/")
def index():
    return render_template("index.html",current_time=datetime.utcnow())

@app.route("/user/<name>")
def user(name):
    return render_template("user.html", name=name)

class NameForm(FlaskForm):
    name=StringField("What is your name?",validators=[DataRequired()])
    submit=SubmitField("Submit")

@app.route("/form",methods=['GET','POST'])
def form():
    form=NameForm()
    if form.validate_on_submit():
        oldName=session.get('name')
        if oldName is not None and oldName!=form.name.data:
            flash("Looks like you hava changed your name!")
        session['name']=form.name.data;
        
        return redirect(url_for('form'))
    return render_template("form.html",form=form,name=session.get('name'));

@app.errorhandler(404)
def page_not_found(e):
    return render_template('404.html'), 404

