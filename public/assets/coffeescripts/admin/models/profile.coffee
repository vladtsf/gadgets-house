class Witness.models.UserProfile extends Backbone.Model

  initialize: ->
    @validation = do =>
      email: [
        required: on
        msg: "Поле не может быть пустым"
      ,
        pattern: 'email'
        msg: "Введите действительный адрес email"
      ]
      password:
        required: not @get( "id" )?
        minLength: 4
        msg: "Пароль должен быть длиннее 4 символов"
      password_repeat:
        equalTo: "password"
        msg: "Пароли не совпадают"

  url: -> "/admin/users/#{ @get( "id" ) ? "" }"