FROM ruby:2.6.4-slim as base
WORKDIR /tmp
COPY ./swagger.yml ./swagger.yml
RUN ruby -ryaml -rjson -e 'puts JSON.pretty_generate(YAML.load(ARGF))' < ./swagger.yml > ./swagger.json

FROM swaggerapi/swagger-ui:latest
ENV BASE_URL /
ENV SWAGGER_JSON /tmp/swagger.json
COPY --from=base /tmp/swagger.json ${SWAGGER_JSON}
