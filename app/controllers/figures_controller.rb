class FiguresController < ApplicationController
  
  get '/figures' do
    @figures = Figure.all
    erb :'/figures/index'
  end
  
  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all

    erb :'/figures/new'
  end

  post '/figures' do
    figure = Figure.create(:name => params[:figure][:name])
    if params[:title][:name].empty?
      figure.title_ids = params[:figure][:title_ids]
    else 
      figure.title_ids = Title.create(:name => params[:title][:name]).id
    end

    if params[:landmark][:name].empty?
      figure.landmark_ids = params[:figure][:landmark_ids]
    else 
      figure.landmark_ids = Landmark.create(:name => params[:landmark][:name]).id
    end

    redirect "/figures/#{figure.id}"

  end

  get '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])

    erb :'/figures/show'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find_by_id(params[:id])
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'/figures/edit'
  end

  patch '/figures/:id' do
    figure = Figure.find_by_id(params[:id])

    figure.update(:name => params[:figure][:name])

    if params[:title][:name].empty?
      figure.title_ids = params[:figure][:title_ids]
    else 
      figure.title_ids = Title.create(:name => params[:title][:name]).id
    end

    if params[:landmark][:name].empty?
      figure.landmark_ids = params[:figure][:landmark_ids]
    else 
      figure.landmark_ids = Landmark.create(:name => params[:landmark][:name]).id
    end
  
    redirect "/figures/#{figure.id}"
  end

end
