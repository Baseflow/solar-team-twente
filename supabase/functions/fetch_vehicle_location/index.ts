export async function handler(req: Request) {
  const apikey = Deno.env.get("SOLAR_API_KEY")!;
  const baseUrl = Deno.env.get("SOLAR_BASE_URL")!;
  const url = new URL(req.url);
  const carId = url.searchParams.get("carId") || "";

  try {
    const response = await fetch(
      `${baseUrl}/cars/${carId}`,
      {
        headers: {
          Accept: "application/json",
          Authorization: `Bearer ${apikey}`,
        },
      },
    );

    const data = await response.json();

    if (response.ok) {
      return new Response(JSON.stringify(data), {
        headers: { "content-type": "application/json" },
        status: response.status,
      })
    } else {
      return new Response(
        response.statusText,
        {
          status: response.status,
        },
      );
    }
  } catch (error) {
    console.error(error);
    return new Response("Internal Server Error", {
      status: 500,
    });
  }
}

Deno.serve(handler);
