
fetch("recursion-demo.ps1")
  .then(response => response.text())
  .then(text => {
    document.getElementById("powershell-code").textContent = text;
  })
  .catch(() => {
    document.getElementById("powershell-code").textContent =
      "Could not load recursion-demo.ps1. The download link may still work.";
  });
