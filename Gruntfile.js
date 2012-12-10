module.exports = function(grunt) {

  grunt.loadNpmTasks( "grunt-jade" )
  grunt.loadNpmTasks( "grunt-contrib-coffee" )
  grunt.loadNpmTasks( "grunt-contrib-concat" )
  grunt.loadNpmTasks( "grunt-contrib-uglify" )
  grunt.loadNpmTasks( "grunt-contrib-less" )
  grunt.loadNpmTasks( "grunt-contrib-watch" )
  grunt.loadNpmTasks( "grunt-contrib-copy" )

  // Project configuration.
  grunt.initConfig({

    coffee: {

      witness: {
        files: {
          "tmp/javascripts/witness/*.js": "public/assets/coffeescripts/witness/*.coffee"
        }
      },

      compile: {
        files: {
          "tmp/javascripts/**.js": "public/assets/coffeescripts/**/*.coffee"
        }
      }
    },

    less: {
      development: {
        options: {
          paths: [ "public/assets/stylesheets/", "vendor/assets/" ]
        },
        files: {
          "static/assets/stylesheets/admin.css": [
            "vendor/assets/fileuploader/client/fineuploader.css",
            "vendor/assets/bootstrap-toggle-buttons/static/stylesheets/bootstrap-toggle-buttons.css",
            "public/assets/stylesheets/admin.less"
          ],
          "static/assets/stylesheets/application.css": [
            "public/assets/stylesheets/application.less"
          ]
        }
      },
      production: {
        options: {
          paths: [ "public/assets/stylesheets/", "vendor/assets/" ],
          yuicompress: true
        },
        files: {
          "static/assets/stylesheets/admin.css": [
            "vendor/assets/fileuploader/client/fineuploader.css",
            "vendor/assets/bootstrap-toggle-buttons/static/stylesheets/bootstrap-toggle-buttons.css",
            "public/assets/stylesheets/admin.less"
          ],
          "static/assets/stylesheets/application.css": [
            "public/assets/stylesheets/application.less"
          ]
        }
      }
    },

    jade: {
      admin: {
        src: ['public/assets/jst/admin/**/*.jade'],
        dest: 'tmp/jst/compiled/admin/',
        options: {
          runtime: false,
        }
      }
    },

    copy: {
      images: {
        files: {
          "static/assets/images/": "public/assets/images/**"
        }
      }
    },

    concat: {
      witness: {
        src: [
          "vendor/assets/javascripts/jquery-1.8.2.js",
          "vendor/assets/javascripts/jquery.form.js",
          "vendor/assets/javascripts/underscore.js",
          "vendor/assets/javascripts/underscore.string.js",
          "vendor/assets/javascripts/backbone.js",
          "vendor/assets/javascripts/backbone-validation.js",
          "vendor/assets/javascripts/jade-runtime.js",
          "tmp/javascripts/witness/*.js",
        ],
        dest: "tmp/javascripts/witness.js",
        separator: ';'
      },

      fileuploader: {
        src: [
          "vendor/assets/fileuploader/client/js/header.js",
          "vendor/assets/fileuploader/client/js/util.js",
          "vendor/assets/fileuploader/client/js/button.js",
          "vendor/assets/fileuploader/client/js/handler.base.js",
          "vendor/assets/fileuploader/client/js/handler.form.js",
          "vendor/assets/fileuploader/client/js/handler.xhr.js",
          "vendor/assets/fileuploader/client/js/uploader.basic.js",
          "vendor/assets/fileuploader/client/js/uploader.js",
          "vendor/assets/fileuploader/client/js/jquery-plugin.js"
        ],
        dest: "tmp/javascripts/fileuploader.js",
        separator: ';'
      },

      bootstrap: {
        src: [
          "vendor/assets/bootstrap/docs/assets/js/bootstrap.js",
          "vendor/assets/bootstrap-toggle-buttons/static/js/jquery.toggle.buttons.js"
        ],
        dest: "tmp/javascripts/bootstrap.js",
        separator: ';'
      },

      jst_admin: {
        src: [
          "tmp/jst/compiled/admin/**/*.js",
        ],
        dest: "tmp/javascripts/jst_admin.js",
        separator: ';'
      },

      admin: {
        src: [
          "tmp/javascripts/witness.js",
          "tmp/javascripts/bootstrap.js",
          "tmp/javascripts/fileuploader.js",
          "tmp/javascripts/jst_admin.js",
          "tmp/javascripts/admin/**/*.js"
        ],
        dest: "static/assets/javascripts/admin.js",
        separator: ';'
      },

      application: {
        src: [
          "tmp/javascripts/witness.js",
          "tmp/javascripts/application/**.js"
        ],
        dest: "static/assets/javascripts/application.js",
        separator: ';'
      }
    },

    uglify: {
      admin: {
        src: [ "static/assets/javascripts/admin.js" ],
        dest: "static/assets/javascripts/admin.min.js"
      },

      application: {
        src: [ "static/assets/javascripts/application.js" ],
        dest: "static/assets/javascripts/application.min.js"
      }
    },


    watch: {
      files: [
        "public/assets/**/**",
      ],
      tasks: [ "dev" ]
    }

  })

  // Default task.
  grunt.registerTask( "default", [ "coffee", "jade", "less:production", "copy", "concat", "uglify" ] )
  grunt.registerTask( "dev", [ "coffee", "jade", "less:development", "copy", "concat" ] )

}