import {createClient} from "https://esm.sh/@supabase/supabase-js@2.43.4";

/**
 * Fetches the vehicle location from the Solar API and upserts it into the database.
 * Skips upserting if the data is not more recent than the latest record in the database.
 */
Deno.serve(async (_req) => {
  const apikey = Deno.env.get("SOLAR_API_KEY")!;
  const baseUrl = Deno.env.get("SOLAR_BASE_URL")!;

  try {
    const response = await fetch(
      `${baseUrl}/leaderboard`,
      {
        headers: {
          Accept: "application/json",
          Authorization: `Bearer ${apikey}`,
        },
      },
    );

    const data = await response.json();
    console.log("Leaderboard fetched:", data);

    if (response.ok) {
      const supabaseUrl = Deno.env.get("SUPABASE_URL")!;
      const supabaseKey = Deno.env.get("SUPABASE_ANON_KEY")!;
      const supabase = createClient(
        supabaseUrl,
        supabaseKey,
      );

      const now = new Date().toISOString();
      for (const entry of data) {
        const vehicleClass = String(entry.vehicle_class).toLowerCase().trim(); // Ensure string and normalize
        if (vehicleClass !== "challenger") {
          console.log("Skipping upsert for vehicle class:", vehicleClass);
          continue;
        }

        const upsertData = {
          name: entry.name, // Accessing properties from 'entry'
          position: entry.position,
          distance: entry.distance,
          number: entry.number,
          vehicle_class: entry.vehicle_class,
          last_updated: now,
        };

        const { error } = await supabase
          .from("leaderboard")
          .upsert(upsertData);

        if (error) {
          console.error(error);
          return new Response(
            `${error.message} ${error.code}` || "Internal Server Error",
            { status: 500 },
          );
        }
      }

      // If all upserts were successful, return the original data
      return new Response(JSON.stringify(data), {
        headers: { "content-type": "application/json" },
        status: response.status,
      });
    }

    return new Response(
      response.statusText,
      { status: response.status },
    );
  } catch (error) {
    console.error(error);
    return new Response(
      error.message || "Internal Server Error",
      { status: error.status || 500 },
    );
  }
});
