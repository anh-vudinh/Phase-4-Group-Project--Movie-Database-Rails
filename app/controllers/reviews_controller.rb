class ReviewsController < ApplicationController
    
    def index
        possibleMovie = Movie.find_by(movie_id: params[:movie_id])
        if possibleMovie 
            render json:  possibleMovie.reviews, status: :ok                     
        else
            render json: [], status: :not_found  
                           
        end
    end 
   
    
    def create 
        filteredComment = filterScriptFromComment(params[:comment])
        user = UserSessionTokenList.all.find_by(session_token: params[:token]).user     #locate user based off token recieved, return hash for id association
        movie = createMovieIfNone(params[:movie_id], params[:movie_name])                                    #create or find movie, return hash for id association
        newReview = Review.create(author: user.username, username: user.username, avatar_path: user.userprofile, rating: params[:rating], content: filteredComment)
        UserReview.create(user_id: user.id, review_id: newReview.id)
        ReviewMovie.create(review_id: newReview.id, movie_id: movie.id)
        render json: newReview, status: :created
    end

    private 
        def review_params 
            params.permit(:comment, :movie_id)
        end
    

    def createMovieIfNone(params_id, params_m_name)
        possibleMovie = Movie.all.find_by(movie_id: params_id)
        if possibleMovie
            possibleMovie      
        else
            Movie.create(movie_id: params_id, movie_name: params_m_name)    
        end
    end

    def filterScriptFromComment(comment)
        if comment.include? "&lt;script&gt;"
            filtered1 = comment.gsub!("&lt;script&gt;", "")
            if filtered1.include? "&lt;/script&gt;"
                filtered1.gsub!("&lt;/script&gt;","")
            else
                filtered1
            end
        else
            comment
        end
    end
end
