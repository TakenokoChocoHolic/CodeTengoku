[![Build Status](https://secure.travis-ci.org/TakenokoChocoHolic/CodeTengoku.png?branch=master)](http://travis-ci.org/TakenokoChocoHolic/CodeTengoku)

# How to start developing
    git clone git@github.com:TakenokoChocoHolic/CodeTengoku.git
    cd CodeTengoku
    git remote add heroku git@heroku.com:almond-choco.git

# How to compile
    npm install -g typescript
    make clean all

# Push commits into GitHub repository
    git push
When pushing commits int GitHub repos, the code is tested automatically with Travis CI. 

# Push commits into Heroku for deploying
    git push heroku master
