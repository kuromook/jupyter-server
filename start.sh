source venv/bin/activate
./cloud_sql_proxy -instances=project-211906:asia-northeast1:sh1-sql=tcp:3306 -credential_file=project-211906-88503801d795.json &
cd /home/sh1/notebook
jupyter notebook --ip=0.0.0.0 --port=9999 --NotebookApp.password='sha1:e65746d3d644:97bac9633bc3d90cd0265f60c8575763667ab1f7'
