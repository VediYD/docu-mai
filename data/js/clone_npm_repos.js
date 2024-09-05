const fs = require("fs").promises;
const https = require("https");
const { exec } = require("child_process");
const path = require("path");

function getGithubUrl(packageName) {
  return new Promise((resolve, reject) => {
    https
      .get(`https://registry.npmjs.org/${packageName}`, (res) => {
        let data = "";
        res.on("data", (chunk) => (data += chunk));
        res.on("end", () => {
          try {
            const packageInfo = JSON.parse(data);
            if (packageInfo.repository && packageInfo.repository.url) {
              let repoUrl = packageInfo.repository.url
                .replace("git+", "")
                .replace("git:", "https:")
                .replace(".git", "");
              resolve(repoUrl);
            } else {
              resolve(null);
            }
          } catch (error) {
            reject(error);
          }
        });
      })
      .on("error", (error) => reject(error));
  });
}

function cloneRepo(repoUrl, packageName) {
  return new Promise((resolve) => {
    if (repoUrl) {
      exec(`git clone ${repoUrl} ${packageName}`, (error) => {
        if (error) {
          console.log(`Failed to clone ${packageName}: ${error.message}`);
          resolve(false);
        } else {
          console.log(`Successfully cloned ${packageName}`);
          resolve(true);
        }
      });
    } else {
      console.log(`Could not find GitHub URL for ${packageName}`);
      resolve(false);
    }
  });
}

async function main() {
  try {
    const data = await fs.readFile("npm_packages.txt", "utf8");
    const packages = data.split("\n").filter((line) => line.trim() !== "");

    for (const packageName of packages) {
      try {
        const githubUrl = await getGithubUrl(packageName);
        await cloneRepo(githubUrl, packageName);
      } catch (error) {
        console.error(`Error processing ${packageName}: ${error.message}`);
      }
    }
  } catch (error) {
    console.error(`Error reading file: ${error.message}`);
  }
}

main();
