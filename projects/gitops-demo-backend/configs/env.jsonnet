// Function to map key-value pairs to Kubernetes env format
local mapEnv(obj) =
  [
    { name: key, value: std.toString(obj[key]) }
    for key in std.objectFields(obj)
  ];

// Function that defines environment variables per namespace
local getMapEnv(namespace) = mapEnv(
  {
    'app-prod': {
      PORT: '8080',
    },
  }[namespace]
);

{
  getMapEnv: getMapEnv,
}
