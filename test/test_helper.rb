# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'quorum_sdk'

require 'minitest/autorun'

SEED_URL = "rum://seed?v=1\u0026e=0\u0026n=0\u0026b=2JAwDQsfR52nvtfghelYhQ\u0026c=ynJAEqtv4o-0cvckSseYw1jhTKWdkcMeNb-DyHGAgmQ\u0026g=nwjjfCt8SlW_tpd1hnlQ_Q\u0026k=A0f-sZyTczWntYTURuFm-xrn-p1MYiianbRqhA9hP2Nn\u0026s=0-WGiJYwFZc3dlDAQLAidVANloZsHYhWvfV5lgK5OCYCPhCXT74lqy-cYhRmeDlp_Wz1qVhooTzG3glVdBr8EAA\u0026t=FzdspvUmsfI\u0026a=my_test_group\u0026y=test_app\u0026u=http%3A%2F%2F127.0.0.1%3A8002%3Fjwt%3DeyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhbGxvd0dyb3VwcyI6WyI5ZjA4ZTM3Yy0yYjdjLTRhNTUtYmZiNi05Nzc1ODY3OTUwZmQiXSwiZXhwIjoxODMwNjA1MjUxLCJuYW1lIjoiYWxsb3ctOWYwOGUzN2MtMmI3Yy00YTU1LWJmYjYtOTc3NTg2Nzk1MGZkIiwicm9sZSI6Im5vZGUifQ.0ZYlE8BbtcxGwlX1phzmk6Tpa0Yaz1vFVfiRssW47Ho"
