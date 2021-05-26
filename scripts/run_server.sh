#!/bin/bash

VENV=./venv
DEPLOY_FLAG=/opt/find-yourself/deploy_state.flag

touch $DEPLOY_FLAG

if [ ! -d $VENV ]; then
    `which python3` -m venv $VENV
    $VENV/bin/pip install -U pip
fi

$VENV/bin/python -m pip install --upgrade pip
$VENV/bin/pip install -r requirements.txt

# $VENV/bin/python src/jobsearcher_project/manage.py migrate --fake sessions zero
# $VENV/bin/python src/jobsearcher_project/manage.py migrate --fake
# $VENV/bin/python src/jobsearcher_project/manage.py migrate --fake-initial
# $VENV/bin/python src/jobsearcher_project/manage.py makemigrations
$VENV/bin/python src/manage.py migrate

$VENV/bin/python src/manage.py collectstatic --no-input
$VENV/bin/python src/manage.py runserver 0.0.0.0:8000

rm -f $DEPLOY_FLAG

echo "Run Django"
