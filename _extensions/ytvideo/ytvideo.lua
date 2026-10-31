
local function html_escape(s)
  return tostring(s):gsub("&", "&amp;")
                  :gsub('"', "&quot;")
                  :gsub("<", "&lt;")
                  :gsub(">", "&gt;")
end

return {
  ["ytvideo"] = function(args)
    local id = pandoc.utils.stringify(args[1] or "")

    if not id:match("^[%w_-]+$") then
      error("Invalid YouTube video ID")
    end

    local video_id = html_escape(id)
    local url = "https://www.youtube.com/watch?v=" .. video_id

    local html = string.format([[
<div class="yt-adaptive"
     style="width:85%%;margin:auto;position:relative;
            aspect-ratio:16/9;">

  <div class="yt-thumbnail" style="display:none;">
    <a href="%s" target="_blank"
       rel="noopener noreferrer"
       style="display:block;position:relative;">

      <img src="thumbnails/%s.webp"
     alt="Open video on YouTube"
     style="display:block;width:100%%;height:100%%;
            aspect-ratio:16/9;object-fit:cover;
            border-radius:12px;">

      <span style="position:absolute;top:50%%;left:50%%;
                   transform:translate(-50%%,-50%%);
                   background:#cc0000;color:white;
                   border-radius:14px;padding:12px 24px;
                   font-size:38px;">&#9654;</span>
    </a>
  </div>

  <iframe class="yt-player"
          data-external="1"
          data-video-id="%s"
          width="1280" height="720"
          style="width:100%%;aspect-ratio:16/9;height:auto;border:0;"
          title="YouTube video player"
          allow="accelerometer; autoplay; clipboard-write;
                 encrypted-media; gyroscope; picture-in-picture;
                 web-share"
          referrerpolicy="strict-origin-when-cross-origin"
          allowfullscreen>
  </iframe>

</div>

<script>
(function() {
  const container = document.currentScript.previousElementSibling;
  const player = container.querySelector(".yt-player");
  const thumbnail = container.querySelector(".yt-thumbnail");

  if (window.location.protocol === "file:") {
    player.remove();
    thumbnail.style.display = "block";
  } else {
    player.src = "https://www.youtube.com/embed/" +
             player.dataset.videoId + "?mute=1";
  }
})();
</script>



]], html_escape(url), video_id, video_id)

    return pandoc.RawBlock("html", html)
  end
}
