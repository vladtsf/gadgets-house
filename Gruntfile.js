module.exports = function(grunt) {

  grunt.loadNpmTasks( "grunt-contrib-coffee" )
  grunt.loadNpmTasks( "grunt-contrib-concat" )
  grunt.loadNpmTasks( "grunt-contrib-uglify" )
  grunt.loadNpmTasks( "grunt-contrib-less" )
  grunt.loadNpmTasks( "grunt-contrib-watch" )

  // Project configuration.
  grunt.initConfig({

    coffee: {
      compile: {
        files: {
          "public/assets/javascripts/**.js": "public/assets/coffeescripts/**/*.coffee"
        }
      }
    },

    concat: {
      admin: {
        src: [
          "vendor/assets/javascripts/jquery-1.8.2.js",
          "vendor/assets/javascripts/underscore.js",
          "vendor/assets/javascripts/backbone.js",
          "public/assets/javascripts/admin/**.js"
        ],
        dest: "public/assets/javascripts/bundles/admin.js",
        separator: ';'
      },

      application: {
        src: [
          "vendor/assets/javascripts/jquery-1.8.2.js",
          "vendor/assets/javascripts/underscore.js",
          "vendor/assets/javascripts/backbone.js",
          "public/assets/javascripts/application/**.js"
        ],
        dest: "public/assets/javascripts/bundles/application.js",
        separator: ';'
      }
    },

    uglify: {
      admin: {
        src: [ "public/assets/javascripts/bundles/admin.js" ],
        dest: "public/assets/javascripts/bundles/admin.min.js"
      },

      application: {
        src: [ "public/assets/javascripts/bundles/application.js" ],
        dest: "public/assets/javascripts/bundles/application.min.js"
      }
    },

    less: {
      development: {
        options: {
          paths: [ "public/assets/less/", "vendor/assets/stylesheets/" ]
        },
        files: {
          "public/assets/stylesheets/*.css": "public/assets/less/*.less"
        }
      },
      production: {
        options: {
          paths: [ "public/assets/less/", "vendor/assets/stylesheets/" ],
          yuicompress: true
        },
        files: {
          "public/assets/stylesheets/*.css": "public/assets/less/*.less"
        }
      }
    },

    watch: {
      files: [
        "public/assets/coffeescripts/**/*",
        "public/assets/less/**/*"
      ],
      tasks: [ "dev" ]
    }

  })

  // Default task.
  grunt.registerTask( "default", [ "coffee", "less:production", "concat", "uglify" ] )
  grunt.registerTask( "dev", [ "coffee", "less:development", "concat" ] )

}