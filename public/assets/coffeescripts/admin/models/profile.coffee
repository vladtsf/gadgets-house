class Witness.models.UserProfile extends Backbone.Model

  initialize: ->

  validation:
    email: [
      required: on
      msg: "Поле не может быть пустым"
    ,
      pattern: 'email'
      msg: "Введите действительный адрес email"
    ]
    password:
      required: off
      minLength: 4
      msg: "Пароль должен быть длиннее 4 символов"
    password_repeat:
      equalTo: "password"
      msg: "Пароли не совпадают"


  url: -> "/admin/users/#{ @get( "id" ) }"