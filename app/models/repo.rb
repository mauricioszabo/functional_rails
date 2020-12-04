module Repo
  extend self

  def users
    db[:users].with_row_proc(proc { |row| User.new(row) })
  end

  private def db
    Sequel::DATABASES[0]
  end
end
