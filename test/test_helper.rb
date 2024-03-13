ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # 指定のワーカー数でテストを並列実行する
  parallelize(workers: :number_of_processors)

  # return true if test user is logging in
  def is_logged_in?
    !session[:user_id].nil?
  end

  # test/fixtures/*.ymlにあるすべてのfixtureをセットアップする
  fixtures :all
  include ApplicationHelper

  # return true if test user logging in
  def is_logged_in?
    !session[:user_id].nil?
  end

  # log in as test user
  def log_in_as(user)
    session[:user_id] = user.id
  end

  # （すべてのテストで使うその他のヘルパーメソッドは省略）
end

class ActionDispatch::IntegrationTest

  def log_in_as(user, password: 'password', remember_me: '1')
    post login_path, params: { session: { email: user.email,
                                          password: password,
                                          remember_me: remember_me } }
  end

end