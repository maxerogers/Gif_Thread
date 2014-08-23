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
		original = '
		<div class="comment tier-'+self.tier.to_s+'">
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
			<button type="button" class="btn btn-primary like_btn"> Like <i class="fa fa-thumbs-up"></i></button>
			</div>
			</div>
		</div>
		<div class="comment_box">
			<h4> [ '+(( (Time.now - self.created_at) /1.minute).round ).to_s+'minutes ago ] '+self.username+' <span> Votes: 0 </span></h4>
			<p> '+self.data+'</p>
		</div>
		<div class="gif_box" style="display:none">
			<img src="'+self.gif_url+'">
		</div>
		<div class="reply_box" style="display:none;">
			<form class="form-inline" role="form">
				<input name="id" type="hidden" value="'+self.id.to_s+'">
				<input name="tier" type="hidden" value="'+(self.tier.to_i + 1).to_s+'">
				<input name="username" class="form-control" type="text" placeholder="Username">
				<input name="gif_url" class="form-control" type="text" placeholder="Gif URL">
			</form>
			<div class="input-group">
			    <textarea class="form-control custom-control" rows="3" style="resize:none" placeholder="Comment..."></textarea> <span class="reply_send_btn input-group-addon btn btn-primary">Submit <i class="fa fa-paper-plane-o"></i></span>
			</div>
		</div>
	</div>
		'
		self.children.each do |c|
			original += c.comment_html
		end
		original
	end
end