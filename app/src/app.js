import express from "express";

const app = express();

app.use(express.json());

app.get("/", (req, res) => {
  res.json({
    text: "Hello World",
  });
});

app.get("/health", (req, res) => {
  res.json({
    timestamp: "2026-02-25T22:14:33Z",
    uptime: "72h 18m",
    environment: "production",
    version: "1.0.3",
  });
});

app.get("/projects", (req, res) => {
  res.json([
    {
      id: 1,
      name: "Smart Home Automation System",
      description:
        "A system to control smart devices remotely through a web and mobile interface.",
      techStack: ["C#", ".NET", "ASP.NET Core", "SQL Server", "React"],
    },
    {
      id: 2,
      name: "Task Management API",
      description:
        "RESTful API for managing tasks with authentication and role-based authorization.",
      techStack: ["Node.js", "Express", "MongoDB", "JWT", "Docker"],
    },
    {
      id: 3,
      name: "Portfolio Website",
      description:
        "Personal developer portfolio with dynamic project rendering.",
      techStack: ["Next.js", "TypeScript", "Tailwind CSS", "Vercel"],
    },
  ]);
});

app.get("/skills", (req, res) => {
  res.json({
    languages: ["C#", "Java", "JavaScript", "TypeScript", "Python"],
    backend: [".NET", "ASP.NET Core", "Node.js", "Express"],
    frontend: ["React", "Next.js", "HTML", "CSS", "Tailwind"],
    databases: ["SQL Server", "MongoDB", "MySQL", "PostgreSQL"],
    infrastructure: ["Linux", "Nginx", "CI/CD", "GitHub Actions"],
    containers: ["Docker", "Docker Compose"],
    tools: ["Git", "VS Code", "Rider", "Postman"],
  });
});

app.listen(3000, (req, res) => {
  console.log("app is listening on port 3000");
});
