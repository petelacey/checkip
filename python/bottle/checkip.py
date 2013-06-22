from bottle import route, run, template, request
import re

@route('/')
def index():
    return template('index_template', ip=get_ip())

def get_ip():
    forwarded_ips = request.headers.get('X-Forwarded-For')
    if forwarded_ips:
        forwarded_ips = forwarded_ips.strip()
        forwarded_ips = re.split("[,\s]+", forwarded_ips)[-1]
    return request.headers.get('Client-IP') or forwarded_ips or request.get('REMOTE_ADDR')

# run(host='localhost', port=8080)
run(host='localhost', port=8080, server='gunicorn', workers=4)
