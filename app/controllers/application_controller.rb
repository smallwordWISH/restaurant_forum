class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  # Devise 客製化屬性的使用說明：  https://github.com/plataformatec/devise#strong-parameters
  # 如要在註冊頁面與更改帳戶資料增加 name 輸入框，需要讓 name 屬性通過 Strong Parameter

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
  
end
