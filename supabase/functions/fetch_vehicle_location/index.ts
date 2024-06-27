import { createClient } from "https://esm.sh/@supabase/supabase-js@2.43.4";

/**
 * Fetches the vehicle location from the Solar API and upserts it into the database.
 * Skips upserting if the data is not more recent than the latest record in the database.
 */
Deno.serve(async (_req) => {
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
      const supabaseUrl = Deno.env.get("SUPABASE_URL")!;
      const supabaseKey = Deno.env.get("SUPABASE_ANON_KEY")!;
      const supabase = createClient(
          supabaseUrl,
          supabaseKey,
      );

      // Fetch the latest record from the database
      const { data: existingRecord, status } = await supabase
        .from("vehicle_locations")
        .select("last_seen")
        .order("last_seen", { ascending: false })
        .limit(1)
        .maybeSingle();

      console.log("Existing record", existingRecord, status);

      // Check if new data is more recent
      const shouldUpsert = !existingRecord || new Date(data.last_seen) > new Date(existingRecord.last_seen);
      console.log("Should upsert", shouldUpsert);

      if (shouldUpsert) {
        await supabase
        .from("vehicle_locations")
        .upsert({
          name: data.name,
          longitude: data.longitude,
          latitude: data.latitude,
          last_seen: data.last_seen,
        });
      }

      return new Response(JSON.stringify(data), {
        headers: { "content-type": "application/json" },
        status: response.status,
      });
    }
    
    return new Response(
      response.statusText,
      { status: response.status, },
    );
  } catch (error) {
    console.error(error);
    return new Response(
      error.message || "Internal Server Error", 
      { status: error.status || 500, }
  );
  }
});