module Nesta
  class App

    use Rack::Auth::Basic, "Protected Area" do |username, password|
      username == 'lior' && password == 'mika09'
    end


    get '/effectiveIT' do
      erb :effectiveIT
    end

    
    get '*' do
      set_common_variables
      parts = params[:splat].map { |p| p.sub(/\/$/, '') }
      @page = Nesta::Page.find_by_path(File.join(parts))
      raise Sinatra::NotFound if @page.nil?
      @title = @page.title
      @articles = Page.find_articles.select { |a| a.date }[0..9]
      set_from_page(:description, :keywords)
      cache haml(@page.template, :layout => @page.layout)
    end

  end
end