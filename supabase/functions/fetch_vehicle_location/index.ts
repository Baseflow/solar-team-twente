import { createClient } from "https://esm.sh/@supabase/supabase-js@2.43.4";

Deno.serve(async (_req) => {
  const supabaseUrl = Deno.env.get("SUPABASE_URL")!;
  const supabaseKey = Deno.env.get("SUPABASE_ANON_KEY")!;
  const supabase = createClient(
    supabaseUrl,
    supabaseKey,
    {
      global: {
        headers: { Authorization: _req.headers.get("Authorization")! },
      },
    },
  );
  const apikey = Deno.env.get("SOLAR_API_KEY")!;
  const baseUrl = Deno.env.get("SOLAR_BASE_URL")!;
  const carId = "DMU";

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
    console.log(data);

    if (response.ok) {
      await supabase
        .from("vehicle_locations")
        .upsert({
          name: data.name,
          longitude: data.longitude,
          latitude: data.latitude,
          last_seen: data.last_seen,
        });

      return new Response(JSON.stringify(data), {
        headers: { "content-type": "application/json" },
        status: response.status,
      });
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
});