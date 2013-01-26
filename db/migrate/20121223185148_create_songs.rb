class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
    t.string	 :song_id
	t.string	 :artist_id	
	t.string	 :track_id
	t.string	 :track_7digitalid
	t.string	 :audio_md5
	t.string	 :title
	t.string	 :album_id #7
	t.integer	 :year #8
	t.float	 :duration #9
	t.float	 :samp_rt #10
	t.float	 :tempo #11
	t.float	 :danceability#, Float #12
	t.float	 :energy#, Float #13
	t.float	 :loudness #, Float #14
	t.float	 :song_hot  #, Float #15
	t.float	 :end_fade_in  #, Float #16   #index of the song's segment
	t.integer	 :song_key  #,Integer  #17 
	t.float	 :key_c        #,Float  #18
	t.integer	 :mode  #, Integer  #19 #minor=0 major=1
	t.float	 :mode_conf  #, Float #20  #precentage
	t.float	 :start_fade_out  #,Float #21
	t.integer	 :time_sig  #, Integer  #22
	t.float	 :time_sig_c  #, Float  #23
	t.float	 :bars_c_avg  #, Float #24
	t.float	 :bars_c_max   #, Float #25
	t.float	 :bars_c_min   #, Float #26
	t.float	 :bars_c_stddev  #, Float #27
	t.float	 :bars_c_count   #, Float #28
	t.float	 :bars_c_sum    #, Float #29
	t.float	 :bars_start_avg   #, Float #30
	t.float	 :bars_start_max  #, Float #31
	t.float	 :bars_start_min   #, Float #32
	t.float	 :bars_start_stddev   #, Float #33
	t.integer	 :bars_start_count  #,Integer #34
	t.float	 :bars_start_sum    #,Float #35
	t.float	 :beats_c_avg      #, Float #36
	t.float	 :beats_c_max    #, Float #37
	t.float	 :beats_c_min    #, Float #38
	t.float	 :beats_c_stddev  #, Float #39
	t.float	 :beats_c_count   #, Float #40
	t.float	 :beats_c_sum     #, Float #41
	t.float	 :beats_start_avg  #, Float #42
	t.float	 :beats_start_max  #, Float #43
	t.float	 :beats_start_min  #, Float #44
	t.float	 :beats_start_stddev  #, Float #45
	t.integer	 :beats_start_count #, Integer #46
	t.float	 :beats_start_sum  #, Float #47
	t.float	 :sec_c_avg     #, Float  #48
	t.float	 :sec_c_max     #, Float  #49
	t.float	 :sec_c_min    #, Float  #50
	t.float	 :sec_c_stddev   #, Float #51
	t.integer	 :sec_c_count  #, Integer #52
	t.float	 :sec_c_sum   #, Float #53
	t.float	 :sec_start_avg  #, Float #54
	t.float	 :sec_start_max   #, Float #55
	t.float	 :sec_start_min   #, Float #56
	t.float	 :sec_start_stddev #, Float #57
	t.integer	 :sec_start_count  #, Integer #58
	t.float	 :sec_start_sum   #, Float #59
	t.float	 :seg_c_avg    #, Float #60
	t.float	 :seg_c_max   #, Float #61
	t.float	 :seg_c_min   #, Float #62
	t.float	 :seg_c_stddev   #, Float #63
	t.integer :seg_c_count #, Integer #64
	t.float	 :seg_c_sum   #, Float #65
	t.float	 :seg_loud_max_avg #, Float #66
	t.float	 :seg_loud_max_max  #, Float #67
	t.float  :seg_loud_max_min  #, Float #68
    t.float	 :seg_loud_max_stddev #, Float #69
	t.integer	 :seg_loud_max_count #, Integer #70
	t.float	 :seg_loud_max_sum   #, Float #71
	t.float	 :seg_loud_max_time_avg #, Float #72
	t.float	 :seg_loud_max_time_max  #, Float #73
	t.float	 :seg_loud_max_time_min  #, Float #74
	t.float	 :seg_loud_max_time_stddev  #, Float #75
	t.integer	 :seg_loud_max_time_count #, Integer #76
	t.float	 :seg_loud_max_time_sum  #, Float #77
	t.float	 :seg_loud_start_avg   #, Float #78
	t.float	 :seg_loud_start_max  #, Float #79
	t.float	 :seg_loud_start_min   #, Float #80
	t.float	 :seg_loud_start_stddev #, Float #81
	t.integer :seg_loud_start_count  #, Integer #82
	t.float	 :seg_loud_start_sum   #, Float  #83
	t.float	 :seg1_pitch_avg # 84,
	t.float	 :seg1_pitch_max # 85
	t.float	 :seg1_pitch_min # 86, 
	t.float	 :seg1_pitch_stddev # 87,
	t.float	 :seg1_pitch_count # 88,
	t.float	 :seg1_pitch_sum #89,
	t.float	 :seg2_pitch_avg #90
	t.float	 :seg2_pitch_max #91
	t.float	 :seg2_pitch_min #92
	t.float	 :seg2_pitch_stddev #93
	t.float	 :seg2_pitch_count # 94
	t.float	 :seg2_pitch_sum  #95
	t.float	 :seg3_pitch_avg #96
	t.float	 :seg3_pitch_max
	t.float	 :seg3_pitch_min 
	t.float	 :seg3_pitch_stddev
	t.float	 :seg3_pitch_count
	t.float	 :seg3_pitch_sum
	t.float	 :seg4_pitch_avg
	t.float	 :seg4_pitch_max
	t.float	 :seg4_pitch_min 
	t.float	 :seg4_pitch_stddev
	t.float	 :seg4_pitch_count
	t.float	 :seg4_pitch_sum
	t.float	 :seg5_pitch_avg
	t.float	 :seg5_pitch_max
	t.float	 :seg5_pitch_min 
	t.float	 :seg5_pitch_stddev
	t.float	 :seg5_pitch_count
	t.float	 :seg5_pitch_sum
	t.float	 :seg6_pitch_avg
	t.float	 :seg6_pitch_max
	t.float	 :seg6_pitch_min 
	t.float	 :seg6_pitch_stddev
	t.float	 :seg6_pitch_count
	t.float	 :seg6_pitch_sum
	t.float	 :seg7_pitch_avg
	t.float	 :seg7_pitch_max
	t.float	 :seg7_pitch_min 
	t.float	 :seg7_pitch_stddev
	t.float	 :seg7_pitch_count
	t.float	 :seg7_pitch_sum
	t.float	 :seg8_pitch_avg
	t.float	 :seg8_pitch_max
	t.float	 :seg8_pitch_min 
	t.float	 :seg8_pitch_stddev
	t.float	 :seg8_pitch_count
	t.float	 :seg8_pitch_sum
	t.float	 :seg9_pitch_avg
	t.float	 :seg9_pitch_max
	t.float	 :seg9_pitch_min 
	t.float	 :seg9_pitch_stddev
	t.float	 :seg9_pitch_count
	t.float	 :seg9_pitch_sum
	t.float	 :seg10_pitch_avg
	t.float	 :seg10_pitch_max
	t.float	 :seg10_pitch_min 
	t.float	 :seg10_pitch_stddev
	t.float	 :seg10_pitch_count
	t.float	 :seg10_pitch_sum
	t.float	 :seg11_pitch_avg
	t.float	 :seg11_pitch_max
	t.float	 :seg11_pitch_min 
	t.float	 :seg11_pitch_stddev
	t.float	 :seg11_pitch_count
	t.float	 :seg11_pitch_sum
	t.float	 :seg12_pitch_avg
	t.float	 :seg12_pitch_max
	t.float	 :seg12_pitch_min 
	t.float	 :seg12_pitch_stddev
	t.float	 :seg12_pitch_count
	t.float	 :seg12_pitch_sum
	t.float	 :seg_start_avg
	t.float	 :seg_start_max
	t.float	 :seg_start_min
	t.float	 :seg_start_stddev
	t.integer	 :seg_start_count
	t.float	 :seg_start_sum
	t.float	 :seg1_timbre_avg
	t.float	 :seg1_timbre_max
	t.float	 :seg1_timbre_min
	t.float	 :seg1_timbre_stddev
	t.float	 :seg1_timbre_count
	t.float	 :seg1_timbre_sum
	t.float	 :seg2_timbre_avg
	t.float	 :seg2_timbre_max
	t.float	 :seg2_timbre_min
	t.float	 :seg2_timbre_stddev
	t.float	 :seg2_timbre_count
	t.float	 :seg2_timbre_sum
	t.float	 :seg3_timbre_avg
	t.float	 :seg3_timbre_max
	t.float	 :seg3_timbre_min
	t.float	 :seg3_timbre_stddev
	t.float	 :seg3_timbre_count
	t.float	 :seg3_timbre_sum
	t.float	 :seg4_timbre_avg
	t.float	 :seg4_timbre_max
	t.float	 :seg4_timbre_min
	t.float	 :seg4_timbre_stddev
	t.float	 :seg4_timbre_count
	t.float	 :seg4_timbre_sum
	t.float	 :seg5_timbre_avg
	t.float	 :seg5_timbre_max
	t.float	 :seg5_timbre_min
	t.float	 :seg5_timbre_stddev
	t.float	 :seg5_timbre_count
	t.float	 :seg5_timbre_sum
	t.float	 :seg6_timbre_avg
	t.float	 :seg6_timbre_max
	t.float	 :seg6_timbre_min
	t.float	 :seg6_timbre_stddev
	t.float	 :seg6_timbre_count
	t.float	 :seg6_timbre_sum
	t.float	 :seg7_timbre_avg
	t.float	 :seg7_timbre_max
	t.float	 :seg7_timbre_min
	t.float	 :seg7_timbre_stddev
	t.float	 :seg7_timbre_count
	t.float	 :seg7_timbre_sum
	t.float	 :seg8_timbre_avg
	t.float	 :seg8_timbre_max
	t.float	 :seg8_timbre_min
	t.float	 :seg8_timbre_stddev
	t.float	 :seg8_timbre_count
	t.float	 :seg8_timbre_sum
	t.float	 :seg9_timbre_avg
	t.float	 :seg9_timbre_max
	t.float	 :seg9_timbre_min
	t.float	 :seg9_timbre_stddev
	t.float	 :seg9_timbre_count
	t.float	 :seg9_timbre_sum
	t.float	 :seg10_timbre_avg
	t.float	 :seg10_timbre_max
	t.float	 :seg10_timbre_min
	t.float	 :seg10_timbre_stddev
	t.float	 :seg10_timbre_count
	t.float	 :seg10_timbre_sum
	t.float	 :seg11_timbre_avg
	t.float	 :seg11_timbre_max
	t.float	 :seg11_timbre_min
	t.float	 :seg11_timbre_stddev
	t.float	 :seg11_timbre_count
	t.float	 :seg11_timbre_sum
	t.float	 :seg12_timbre_avg
	t.float	 :seg12_timbre_max
	t.float	 :seg12_timbre_min
	t.float	 :seg12_timbre_stddev
	t.float	 :seg12_timbre_count
	t.float	 :seg12_timbre_sum
	t.float	 :tatms_c_avg
	t.float	 :tatms_c_max
	t.float	 :tatms_c_min
	t.float	 :tatms_c_stddev
	t.float	 :tatms_c_count
	t.float	 :tatms_c_sum
	t.float	 :tatms_start_avg
	t.float	 :tatms_start_max
	t.float	 :tatms_start_min
	t.float	 :tatms_start_stddev
	t.integer	 :tatms_start_count
	t.float	 :tatms_start_sum
    end
  end
end
