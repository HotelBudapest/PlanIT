class SetDefaultCreatorIdInEvents < ActiveRecord::Migration[6.1]
  def up
    default_user = User.new(
      email: 'default@example.com',
      password: 'password',
      password_confirmation: 'password'
    )
    default_user.assign_attributes(
      first_name: 'Default',
      last_name: 'User',
      phone_number: '1234567890'
    )
    default_user.save!(validate: false)

    Event.where(creator_id: nil).update_all(creator_id: default_user.id)

    change_column_null :events, :creator_id, false
  end

  def down
    change_column_null :events, :creator_id, true
  end
end
