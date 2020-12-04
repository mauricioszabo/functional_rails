class User
  REQUIRED_FIELDS = [:id, :login, :password, :role]
  include Anima.new(*REQUIRED_FIELDS)

  def self.empty
    new( REQUIRED_FIELDS.map { |field| [field, nil] }.to_h )
  end

  def self.create(params)
    without_id = REQUIRED_FIELDS.drop(1)
    params = without_id.map { |f| [f, params[f]] }.to_h
    user = User.empty.with(params)

    errors = {}
    errors[:login] = ["must be present"] if params[:login].blank?
    errors[:password] = ["must be present"] if params[:password].blank?
    errors[:role] = ["must be present"] if params[:role].blank?

    if errors.empty?
      id = Repo.users.insert(params)
      {record: user.with(id: id)}
    else
      {errors: errors, record: user}
    end
  end
end
