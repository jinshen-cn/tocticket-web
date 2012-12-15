$.jwplayer =
  resize_on_small_screens: (video_id) ->
    if $(window).width() < 467
      jwplayer(video_id).resize(280, 160)
    else if $(window).width() < 767
      jwplayer(video_id).resize(430, 240)
    else
      jwplayer(video_id).resize(480, 270)
# Page load event
$(window).bind("load", ->
  $.jwplayer.resize_on_small_screens('promo-video')
)
# Resizing event
$(window).resize ->
  $.jwplayer.resize_on_small_screens('promo-video')
