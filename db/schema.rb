# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130412082449) do

  create_table "albums", :primary_key => "release_7digitalid", :force => true do |t|
    t.string "name"
  end

  create_table "artist_albums", :force => true do |t|
    t.string "artist_id"
    t.string "album_id"
  end

  create_table "artist_terms", :force => true do |t|
    t.string  "artist_id"
    t.string  "song_id"
    t.string  "name"
    t.float   "freq"
    t.float   "weight"
    t.integer "term_id"
    t.string  "category"
  end

  add_index "artist_terms", ["artist_id"], :name => "index_artist_terms_on_artist_id"
  add_index "artist_terms", ["name"], :name => "index_artist_terms_on_name"
  add_index "artist_terms", ["term_id"], :name => "index_artist_terms_on_term_id"

  create_table "artists", :id => false, :force => true do |t|
    t.string  "id",                                :null => false
    t.string  "artist_7digital_id"
    t.string  "artist_mbid"
    t.string  "artist_pm_id"
    t.string  "artist_name"
    t.float   "artist_hotness"
    t.float   "artist_fam"
    t.integer "songs_count",        :default => 0
    t.integer "similars_count",     :default => 0
  end

  create_table "attribute_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "attribute_category_relations", :force => true do |t|
    t.integer  "attribute_id"
    t.integer  "attribute_category_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  create_table "attributes", :force => true do |t|
    t.string   "attribute_name"
    t.string   "attribute_type"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "table_id"
    t.string   "alter_name"
    t.text     "fact_actions"
    t.text     "dim_actions"
  end

  create_table "facts", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "name"
    t.integer  "table_id"
  end

  create_table "queries", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.hstore   "args"
    t.integer  "fact_id"
    t.string   "query_type"
    t.text     "results"
  end

  add_index "queries", ["args"], :name => "queries_args"

  create_table "similarities", :force => true do |t|
    t.string "artist_id"
    t.string "target_id"
  end

  add_index "similarities", ["artist_id"], :name => "index_similarities_on_artist_id"

  create_table "snow_dims", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "star_dim_id"
    t.integer  "table_id"
  end

  create_table "songs", :id => false, :force => true do |t|
    t.string  "song_id"
    t.string  "artist_id"
    t.string  "track_id",                 :null => false
    t.string  "track_7digitalid"
    t.string  "audio_md5"
    t.string  "title"
    t.string  "album_id"
    t.integer "year"
    t.float   "duration"
    t.float   "samp_rt"
    t.float   "tempo"
    t.float   "danceability"
    t.float   "energy"
    t.float   "loudness"
    t.float   "song_hot"
    t.float   "end_fade_in"
    t.integer "song_key"
    t.float   "key_c"
    t.integer "mode"
    t.float   "mode_conf"
    t.float   "start_fade_out"
    t.integer "time_sig"
    t.float   "time_sig_c"
    t.float   "bars_c_avg"
    t.float   "bars_c_max"
    t.float   "bars_c_min"
    t.float   "bars_c_stddev"
    t.float   "bars_c_count"
    t.float   "bars_c_sum"
    t.float   "bars_start_avg"
    t.float   "bars_start_max"
    t.float   "bars_start_min"
    t.float   "bars_start_stddev"
    t.integer "bars_start_count"
    t.float   "bars_start_sum"
    t.float   "beats_c_avg"
    t.float   "beats_c_max"
    t.float   "beats_c_min"
    t.float   "beats_c_stddev"
    t.float   "beats_c_count"
    t.float   "beats_c_sum"
    t.float   "beats_start_avg"
    t.float   "beats_start_max"
    t.float   "beats_start_min"
    t.float   "beats_start_stddev"
    t.integer "beats_start_count"
    t.float   "beats_start_sum"
    t.float   "sec_c_avg"
    t.float   "sec_c_max"
    t.float   "sec_c_min"
    t.float   "sec_c_stddev"
    t.integer "sec_c_count"
    t.float   "sec_c_sum"
    t.float   "sec_start_avg"
    t.float   "sec_start_max"
    t.float   "sec_start_min"
    t.float   "sec_start_stddev"
    t.integer "sec_start_count"
    t.float   "sec_start_sum"
    t.float   "seg_c_avg"
    t.float   "seg_c_max"
    t.float   "seg_c_min"
    t.float   "seg_c_stddev"
    t.integer "seg_c_count"
    t.float   "seg_c_sum"
    t.float   "seg_loud_max_avg"
    t.float   "seg_loud_max_max"
    t.float   "seg_loud_max_min"
    t.float   "seg_loud_max_stddev"
    t.integer "seg_loud_max_count"
    t.float   "seg_loud_max_sum"
    t.float   "seg_loud_max_time_avg"
    t.float   "seg_loud_max_time_max"
    t.float   "seg_loud_max_time_min"
    t.float   "seg_loud_max_time_stddev"
    t.integer "seg_loud_max_time_count"
    t.float   "seg_loud_max_time_sum"
    t.float   "seg_loud_start_avg"
    t.float   "seg_loud_start_max"
    t.float   "seg_loud_start_min"
    t.float   "seg_loud_start_stddev"
    t.integer "seg_loud_start_count"
    t.float   "seg_loud_start_sum"
    t.float   "seg1_pitch_avg"
    t.float   "seg1_pitch_max"
    t.float   "seg1_pitch_min"
    t.float   "seg1_pitch_stddev"
    t.float   "seg1_pitch_count"
    t.float   "seg1_pitch_sum"
    t.float   "seg2_pitch_avg"
    t.float   "seg2_pitch_max"
    t.float   "seg2_pitch_min"
    t.float   "seg2_pitch_stddev"
    t.float   "seg2_pitch_count"
    t.float   "seg2_pitch_sum"
    t.float   "seg3_pitch_avg"
    t.float   "seg3_pitch_max"
    t.float   "seg3_pitch_min"
    t.float   "seg3_pitch_stddev"
    t.float   "seg3_pitch_count"
    t.float   "seg3_pitch_sum"
    t.float   "seg4_pitch_avg"
    t.float   "seg4_pitch_max"
    t.float   "seg4_pitch_min"
    t.float   "seg4_pitch_stddev"
    t.float   "seg4_pitch_count"
    t.float   "seg4_pitch_sum"
    t.float   "seg5_pitch_avg"
    t.float   "seg5_pitch_max"
    t.float   "seg5_pitch_min"
    t.float   "seg5_pitch_stddev"
    t.float   "seg5_pitch_count"
    t.float   "seg5_pitch_sum"
    t.float   "seg6_pitch_avg"
    t.float   "seg6_pitch_max"
    t.float   "seg6_pitch_min"
    t.float   "seg6_pitch_stddev"
    t.float   "seg6_pitch_count"
    t.float   "seg6_pitch_sum"
    t.float   "seg7_pitch_avg"
    t.float   "seg7_pitch_max"
    t.float   "seg7_pitch_min"
    t.float   "seg7_pitch_stddev"
    t.float   "seg7_pitch_count"
    t.float   "seg7_pitch_sum"
    t.float   "seg8_pitch_avg"
    t.float   "seg8_pitch_max"
    t.float   "seg8_pitch_min"
    t.float   "seg8_pitch_stddev"
    t.float   "seg8_pitch_count"
    t.float   "seg8_pitch_sum"
    t.float   "seg9_pitch_avg"
    t.float   "seg9_pitch_max"
    t.float   "seg9_pitch_min"
    t.float   "seg9_pitch_stddev"
    t.float   "seg9_pitch_count"
    t.float   "seg9_pitch_sum"
    t.float   "seg10_pitch_avg"
    t.float   "seg10_pitch_max"
    t.float   "seg10_pitch_min"
    t.float   "seg10_pitch_stddev"
    t.float   "seg10_pitch_count"
    t.float   "seg10_pitch_sum"
    t.float   "seg11_pitch_avg"
    t.float   "seg11_pitch_max"
    t.float   "seg11_pitch_min"
    t.float   "seg11_pitch_stddev"
    t.float   "seg11_pitch_count"
    t.float   "seg11_pitch_sum"
    t.float   "seg12_pitch_avg"
    t.float   "seg12_pitch_max"
    t.float   "seg12_pitch_min"
    t.float   "seg12_pitch_stddev"
    t.float   "seg12_pitch_count"
    t.float   "seg12_pitch_sum"
    t.float   "seg_start_avg"
    t.float   "seg_start_max"
    t.float   "seg_start_min"
    t.float   "seg_start_stddev"
    t.integer "seg_start_count"
    t.float   "seg_start_sum"
    t.float   "seg1_timbre_avg"
    t.float   "seg1_timbre_max"
    t.float   "seg1_timbre_min"
    t.float   "seg1_timbre_stddev"
    t.float   "seg1_timbre_count"
    t.float   "seg1_timbre_sum"
    t.float   "seg2_timbre_avg"
    t.float   "seg2_timbre_max"
    t.float   "seg2_timbre_min"
    t.float   "seg2_timbre_stddev"
    t.float   "seg2_timbre_count"
    t.float   "seg2_timbre_sum"
    t.float   "seg3_timbre_avg"
    t.float   "seg3_timbre_max"
    t.float   "seg3_timbre_min"
    t.float   "seg3_timbre_stddev"
    t.float   "seg3_timbre_count"
    t.float   "seg3_timbre_sum"
    t.float   "seg4_timbre_avg"
    t.float   "seg4_timbre_max"
    t.float   "seg4_timbre_min"
    t.float   "seg4_timbre_stddev"
    t.float   "seg4_timbre_count"
    t.float   "seg4_timbre_sum"
    t.float   "seg5_timbre_avg"
    t.float   "seg5_timbre_max"
    t.float   "seg5_timbre_min"
    t.float   "seg5_timbre_stddev"
    t.float   "seg5_timbre_count"
    t.float   "seg5_timbre_sum"
    t.float   "seg6_timbre_avg"
    t.float   "seg6_timbre_max"
    t.float   "seg6_timbre_min"
    t.float   "seg6_timbre_stddev"
    t.float   "seg6_timbre_count"
    t.float   "seg6_timbre_sum"
    t.float   "seg7_timbre_avg"
    t.float   "seg7_timbre_max"
    t.float   "seg7_timbre_min"
    t.float   "seg7_timbre_stddev"
    t.float   "seg7_timbre_count"
    t.float   "seg7_timbre_sum"
    t.float   "seg8_timbre_avg"
    t.float   "seg8_timbre_max"
    t.float   "seg8_timbre_min"
    t.float   "seg8_timbre_stddev"
    t.float   "seg8_timbre_count"
    t.float   "seg8_timbre_sum"
    t.float   "seg9_timbre_avg"
    t.float   "seg9_timbre_max"
    t.float   "seg9_timbre_min"
    t.float   "seg9_timbre_stddev"
    t.float   "seg9_timbre_count"
    t.float   "seg9_timbre_sum"
    t.float   "seg10_timbre_avg"
    t.float   "seg10_timbre_max"
    t.float   "seg10_timbre_min"
    t.float   "seg10_timbre_stddev"
    t.float   "seg10_timbre_count"
    t.float   "seg10_timbre_sum"
    t.float   "seg11_timbre_avg"
    t.float   "seg11_timbre_max"
    t.float   "seg11_timbre_min"
    t.float   "seg11_timbre_stddev"
    t.float   "seg11_timbre_count"
    t.float   "seg11_timbre_sum"
    t.float   "seg12_timbre_avg"
    t.float   "seg12_timbre_max"
    t.float   "seg12_timbre_min"
    t.float   "seg12_timbre_stddev"
    t.float   "seg12_timbre_count"
    t.float   "seg12_timbre_sum"
    t.float   "tatms_c_avg"
    t.float   "tatms_c_max"
    t.float   "tatms_c_min"
    t.float   "tatms_c_stddev"
    t.float   "tatms_c_count"
    t.float   "tatms_c_sum"
    t.float   "tatms_start_avg"
    t.float   "tatms_start_max"
    t.float   "tatms_start_min"
    t.float   "tatms_start_stddev"
    t.integer "tatms_start_count"
    t.float   "tatms_start_sum"
  end

  add_index "songs", ["album_id"], :name => "index_songs_on_album_id"
  add_index "songs", ["artist_id"], :name => "index_songs_on_artist_id"
  add_index "songs", ["danceability"], :name => "index_songs_on_danceability"
  add_index "songs", ["energy"], :name => "index_songs_on_energy"
  add_index "songs", ["loudness"], :name => "index_songs_on_loudness"
  add_index "songs", ["song_hot"], :name => "index_songs_on_song_hot"
  add_index "songs", ["song_key"], :name => "index_songs_on_song_key"
  add_index "songs", ["tempo"], :name => "index_songs_on_tempo"

  create_table "star_dims", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "fact_id"
    t.integer  "table_id"
  end

  create_table "tables", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "terms", :force => true do |t|
    t.string  "term"
    t.string  "category"
    t.integer "count"
    t.float   "freq_avg"
    t.float   "weight_avg"
    t.integer "genre_count"
  end

end
