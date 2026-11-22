const fs = require("node:fs");
const path = require("node:path");

const root = path.resolve(__dirname, "..");
const dist = path.join(root, "dist");

fs.rmSync(dist, { recursive: true, force: true });
fs.mkdirSync(dist, { recursive: true });

fs.cpSync(path.join(root, "src"), dist, { recursive: true });
fs.mkdirSync(path.join(dist, "style"), { recursive: true });
fs.copyFileSync(
    path.join(root, "style", "style.css"),
    path.join(dist, "style", "style.css")
);

for (const file of fs.readdirSync(dist)) {
    if (!file.endsWith(".html")) continue;

    const htmlPath = path.join(dist, file);
    const html = fs.readFileSync(htmlPath, "utf8");
    fs.writeFileSync(
        htmlPath,
        html.replaceAll("../style/style.css", "style/style.css")
    );
}
