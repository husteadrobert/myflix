class GenerateTokensForExistingUsers < ActiveRecord::Migration
  def change
    User.all.each do |user|
      user.update_column(:token, SecureRandom.urlsafe_base64)
      #This bypasses any validations, b/c of issues with password (which is not a column on User)
    end
  end
end
