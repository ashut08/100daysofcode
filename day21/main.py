from flask import  Flask, render_template, url_for, flash, redirect
from registeration import RegForm,LoginForm



app = Flask(__name__)
app.config['SECRET_KEY']='d35604163ea17368193d893066d9328a'
@app.route("/home")
def home():
    return render_template('home.html',title='Home Page')

@app.route("/register",methods=['GET','POST'])
def register():
    form=RegForm()
    if form.validate_on_submit():
        flash('Account created for {form.username.data}!', 'success')
       
    return render_template('register.html',title='Registration',form=form)
@app.route("/login",methods=['GET','POST'])
def login():
    form=LoginForm() 

    if form.validate_on_submit():
        if form.email.data == 'ashu08@gmail.com' and form.password.data == 'password':
            flash('You have been logged in!','success')
          
        else:
            flash('Login Unsuccessful. Please check username and password', 'danger')
    return render_template('login.html',title='login',form=form)
