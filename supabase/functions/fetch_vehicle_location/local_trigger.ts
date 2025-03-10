/**
 * Manual trigger for the fetch_vehicle_location function.
 * Only works in a local development environment.
 */
const triggerFunction = async () => {
  const supabaseKey = Deno.env.get('SUPABASE_ANON_KEY');
  try {
    const response = await fetch(
      'http://127.0.0.1:54321/functions/v1/fetch_vehicle_location',
      {
        headers: {
          'Authorization': `Bearer ${supabaseKey}`,
        },
      },
    );
    if (!response.ok) {
      console.error(response.statusText);
    }
    const data = await response.json();
    console.log(data);
  } catch (error) {
    console.error(error);
  }
}

// Run the function every 10 seconds
setInterval(triggerFunction, 10000);