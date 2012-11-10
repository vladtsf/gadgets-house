module.exports = function(grunt) {

  grunt.loadNpmTasks( "grunt-jade" )
  grunt.loadNpmTasks( "grunt-contrib-coffee" )
  grunt.loadNpmTasks( "grunt-contrib-concat" )
  grunt.loadNpmTasks( "grunt-contrib-uglify" )
  grunt.loadNpmTasks( "grunt-contrib-less" )
  grunt.loadNpmTasks( "grunt-contrib-watch" )

  // Project configuration.
  grunt.initConfig({

    coffee: {

      witness: {
        files: {
          "public/assets/javascripts/witness/*.js": "public/assets/coffeescripts/witness/*.coffee"
        }
      },

      compile: {
        files: {
          "public/assets/javascripts/**.js": "public/assets/coffeescripts/**/*.coffee"
        }
      }
    },

    concat: {
      witness: {
        src: [
          "vendor/assets/javascripts/jquery-1.8.2.js",
          "vendor/assets/javascripts/underscore.js",
          "vendor/assets/javascripts/backbone.js",
          "vendor/assets/javascripts/jade-runtime.js",
          "public/assets/javascripts/witness/*.js",
        ],
        dest: "public/assets/javascripts/bundles/witness.js",
        separator: ';'
      },

      jst_admin: {
        src: [
          "public/assets/jst/compiled/admin/**/*.js",
        ],
        dest: "public/assets/javascripts/bundles/jst_admin.js",
        separator: ';'
      },

      admin: {
        src: [
          "public/assets/javascripts/bundles/witness.js",
          "public/assets/javascripts/bundles/jst_admin.js",
          "public/assets/javascripts/admin/**/*.js"
        ],
        dest: "public/assets/javascripts/bundles/admin.js",
        separator: ';'
      },

      application: {
        src: [
          "public/assets/javascripts/bundles/witness.js",
          "public/assets/javascripts/application/**.js"
        ],
        dest: "public/assets/javascripts/bundles/application.js",
        separator: ';'
      }
    },

    jade: {
      admin: {
        src: ['public/assets/jst/admin/**/*.jade'],
        dest: 'public/assets/jst/compiled/admin/',
        options: {
          runtime: false,
        }
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
        "public/assets/less/**/*",
        "public/assets/jst/admin/**/*"
      ],
      tasks: [ "dev" ]
    }

  })

  // Default task.
  grunt.registerTask( "default", [ "coffee", "jade", "less:production", "concat", "uglify" ] )
  grunt.registerTask( "dev", [ "coffee", "jade", "less:development", "concat" ] )

}