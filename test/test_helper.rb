# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'quorum_sdk'

require 'minitest/autorun'

SEED = "rum://seed?v=1\u0026e=0\u0026n=0\u0026b=iYMRYrL6Qzi3jpqVqhnWhQ\u0026c=Sktj6TLrLXDd3y7n6rptiCwVxN0-tG2amCTFb5yzmK8\u0026g=7OobccczQp-IyWu2M3jEkA\u0026k=AvoK6jQoRHdGjYdYp_sjtHGV2g7Pdz2B6LxFYZ_p5s89\u0026s=QDlI0wnMNvCyRetaOKEMiWj0w_Cg9fkyICiYgeS581psEwBKp8CpDzDECaFGxvcR8mIi4dcytDhGIvXBRpJq4wA\u0026t=Fzeb_vxQ9T8\u0026a=my_test_group\u0026y=test_app\u0026u=http%3A%2F%2F127.0.0.1%3A8002%3Fjwt%3DeyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhbGxvd0dyb3VwcyI6WyJlY2VhMWI3MS1jNzMzLTQyOWYtODhjOS02YmI2MzM3OGM0OTAiXSwiZXhwIjoxODMwNjU3MzA2LCJuYW1lIjoiYWxsb3ctZWNlYTFiNzEtYzczMy00MjlmLTg4YzktNmJiNjMzNzhjNDkwIiwicm9sZSI6Im5vZGUifQ.n8PFKEIyoJSI9bU73uV5p0ZSC2yVD2eJLcdlzTPr-ts"

HTTP_SEED =
  if File.exist?("#{__dir__}/config.json")
    JSON.parse File.read("#{__dir__}/config.json")
  else
    {}
  end
