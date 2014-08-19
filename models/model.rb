require "sinatra/activerecord"
class Model < ActiveRecord::Base
	#Empty class
	#Has one field: name (string)
end

class Comment < ActiveRecord::Base
	has_many :children, class_name: "Comment", foreign_key: "parent_id"
	belongs_to :parent, class_name: "Comment"
	validates_presence_of :username, :gif_url, :data 
	#Username :string
	#Gif_url :string
	#data :string
	#Parent :comment
	#Comments :comments

	def comment_html
		'
		<div class="comment">
		<div class="img_box">
			<img class="thumb_gif" src="'+self.gif_url+'">
			<div class="btn-group btn-group-justified">
			<div class="btn-group">
			<button type="button" class="btn btn-primary replay_btn">Replay <i class="fa fa-share"></i></button>
			</div>
			<div class="btn-group">
			<button type="button" class="btn btn-primary enlarge_btn">Enlarge <i class="fa fa-search-plus"></i></button>
			</div>
			<div class="btn-group">
			<button type="button" class="btn btn-primary"> Report <i class="fa fa-ban"></i></button>
			</div>
			</div>
		</div>
		<div class="comment_box">
			<h4> [1 Hour Ago] '+self.username+'</h4>
			<p> '+self.data+'</p>
		</div>
		<div class="gif_box" style="display:none">
			<img src="'+self.gif_url+'">
		</div>
		<div class="reply_box" style="display:none;">
			<form class="form-inline" role="form">
				<input  class="form-control" type="text" placeholder="Username">
				<input  class="form-control" type="text" placeholder="Gif URL">
			</form>
			<div class="input-group">
			    <textarea class="form-control custom-control" rows="3" style="resize:none" placeholder="Comment..."></textarea> <span class="reply_send_btn input-group-addon btn btn-primary">Submit <i class="fa fa-paper-plane-o"></i></span>
			</div>
		</div>
	</div>
		'
	end
end