
document.addEventListener("DOMContentLoaded", () => {
  const label = document.createElement("div");

  label.style.cssText = `
    position: fixed;
    z-index: 999999;
    background: rgba(0,0,0,0.8);
    color: white;
    padding: 4px 8px;
    font: 16px monospace;
    border-radius: 4px;
    pointer-events: none;
  `;

  document.body.appendChild(label);

  document.addEventListener("mousemove", (e) => {
    const slide = Reveal.getCurrentSlide();
    if (!slide) return;

    const rect = slide.getBoundingClientRect();

    const x = Math.round((e.clientX - rect.left) * 1920 / rect.width);
    const y = Math.round((e.clientY - rect.top) * 1080 / rect.height);

    label.textContent = `X: ${x} Y: ${y}`;
    label.style.left = (e.clientX + 15) + "px";
    label.style.top = (e.clientY + 15) + "px";
  });
});
