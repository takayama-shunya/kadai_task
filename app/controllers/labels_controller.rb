class LabelsController < ApplicationController

  def new
    @label = Label.new
  end

  def create
    @label = current_user.labels.build(label_params)

    if @label.save
      redirect_to labels_path, notice: "ラベル作成しました！"
    else
      render :new 
    end
  end

  def index
    @labels = Label.where(user_id: current_user.id)
    @labels_default = Label.where(user_id: nil)  if current_user.admin == true
  end

  def destroy
    @label = Label.find(params[:id])
    @label.destroy
    redirect_to labels_path, notice: "ラベル削除しました"
  end

  private

  def label_params
    params.require(:label).permit(:name)
  end    

end
