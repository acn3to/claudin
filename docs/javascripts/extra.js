/* ============================================================
   CLAUDIN — Custom JavaScript
   Subtle interactions for the documentation
   ============================================================ */

document.addEventListener("DOMContentLoaded", function () {
  // Animate feature cards on scroll
  const observer = new IntersectionObserver(
    (entries) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) {
          entry.target.style.opacity = "1";
          entry.target.style.transform = "translateY(0)";
          observer.unobserve(entry.target);
        }
      });
    },
    { threshold: 0.1, rootMargin: "0px 0px -40px 0px" }
  );

  document.querySelectorAll(".cl-feature").forEach((card, i) => {
    card.style.opacity = "0";
    card.style.transform = "translateY(20px)";
    card.style.transition = `opacity 0.5s ease ${i * 0.08}s, transform 0.5s ease ${i * 0.08}s`;
    observer.observe(card);
  });

  // Animate stats on scroll
  document.querySelectorAll(".cl-stat-value").forEach((el) => {
    const io = new IntersectionObserver(
      (entries) => {
        entries.forEach((entry) => {
          if (entry.isIntersecting) {
            animateValue(el);
            io.unobserve(el);
          }
        });
      },
      { threshold: 0.5 }
    );
    io.observe(el);
  });
});

function animateValue(el) {
  const text = el.textContent.trim();
  const match = text.match(/^(\d+)(\+?)$/);
  if (!match) return;

  const target = parseInt(match[1], 10);
  const suffix = match[2] || "";
  const duration = 1200;
  const start = performance.now();

  function step(now) {
    const elapsed = now - start;
    const progress = Math.min(elapsed / duration, 1);
    const eased = 1 - Math.pow(1 - progress, 3); // easeOutCubic
    const current = Math.round(target * eased);
    el.textContent = current + suffix;
    if (progress < 1) requestAnimationFrame(step);
  }

  el.textContent = "0" + suffix;
  requestAnimationFrame(step);
}
