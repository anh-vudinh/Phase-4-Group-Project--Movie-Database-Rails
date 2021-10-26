class ResponsesController < ApplicationController
   
    def show 
        review_responses = ReviewResponse.all.filter{ |rr| rr.review_id == params[:id].to_i}
        send = review_responses.map{|e| e.response}
        render json: send, status: :ok
    end
   
    def create
        filteredComment = filterScriptFromComment(params[:comment])
        user = UserSessionTokenList.all.find_by(session_token: params[:token]).user
        reviewID = createReviewResponseIfNone(params[:review_id], params[:movie_id])
        newResponse = Response.create(author: user.username, username: user.username, avatar_path: user.avatar_path, content: filteredComment)
        ReviewResponse.create(response_id: newResponse.id, review_id: reviewID)
        render json: newResponse, status: :created
    end
        
    private
    def response_params
        params.permit(:review_id,:movie_id)
    end

    def createReviewResponseIfNone(params_id, params_m_id)
        possibleReview = Review.all.find_by(id: params_id)
        if possibleReview == nil
            newReviewMovie = ReviewMovie.create(movie_id: params_m_id, review_id: params_id)
            newReviewMovie.review_id
        else
            possibleReview.id
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
