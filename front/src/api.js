// api.js
async function fetchInfo(username) {
  try {
    const response = await fetch("http://pject/backend/getImportant.php", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({ username: username }),
    });

    if (!response.ok) {
      throw new Error("HTTP Error: " + response.status);
    }

    const responseData = await response.text();

    const data = JSON.parse(responseData);
    return data;
  } catch (error) {
    console.error("Error fetching data:", error);
    throw error;
  }
}

export { fetchInfo };
