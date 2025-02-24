// Function to map ecret key-value pairs to Kubernetes secret format
local mapSecret(obj) =
  [
    {
      name: key,
      valueFrom: {
        secretKeyRef: {
          name: obj[key].secret,
          key: obj[key].key,
        },
      },
    }
    for key in std.objectFields(obj)
  ];

// Function that defines environment variables per namespace
local getMapSecret(namespace) = mapSecret(
  {
    'app-prod': {
      DB_USERNAME: {
        secret: 'cnc-recruit-db-credentials',
        key: 'username',
      },

    },
  }[namespace]
);

{
  getMapSecret: getMapSecret,
}
