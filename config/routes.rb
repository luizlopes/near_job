Rails.application.routes.draw do

  apipie
  namespace :v1, module: 'api/v1' do
    get '/vagas/:vaga_id/candidaturas/ranking', to: 'job_candidates#ranking'
    post '/vagas', to: 'jobs#create'
    post '/pessoas', to: 'people#create'
    post '/candidaturas', to: 'job_candidates#create'
  end
end
