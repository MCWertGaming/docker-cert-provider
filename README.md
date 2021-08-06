# Docker cert provider

This a really small docker container for storing your root or any other certificate inside of a docker container for later use. It's quiet handy while working with docker micro services while using a locally hosted [smallstep certificate](https://github.com/smallstep/certificates) instance.

## Building

The building process is quiet easy. Everyting is done using variables like the following example:
```bash
docker build . \
    --tag registry.your.domain/container-name \
    --build-arg CA_URL=https://ca.your.domain \
    --build-arg CA_FINGERPRINT=fingerprint-here
```
The `--tag` argument sets your container name, either just a local name or the complete name including your docker registry.

The `--build-arg` argument sets the required build arguments required by the step-cli to access your CA server.

The `CA_URL` variable holds the url to your CA server including the protocoll (http/https).

The `CA_FINGERPRINT` variable holds the fingerprint of your root certificate. This validation is required for security reasons by step-ca. It gets printed out after you initialized your CA server. If you haven't saved it or forgot it you can still recover it [as explained in the official documentation](https://smallstep.com/docs/step-ca/getting-started#accessing-your-certificate-authority).

## Building using custom docker registries
The process of building the container with custom docker registries is also done using environment variables. A good reason for doing that is for example, if you want to use a proxied docker registry to save brand-width or to speed up building. This is not required, but optional. If none custom registries are set, the original and public registries are used. Switching registries can be done with the following command:
```
docker build . \
    --tag registry.your.domain/container-name \
    --build-arg CA_URL=https://ca.your.domain \
    --build-arg CA_FINGERPRINT=fingerprint-here \
    # repository configuration
    --build-arg REGISTRY_DOCKERHUB=registry.your.domain \docker build . \
    --tag registry.your.domain/container-name \
    --build-arg CA_URL=https://ca.local.leven.dev \
    --build-arg CA_FINGERPRINT=364328da65032b9f42cc3805c3ce431e58ec5575891eee7336b6642d0b905b05 \
    # repository configuration
    --build-arg REGISTRY_DOCKERHUB=docker-private.nexus.local.leven.dev \
    --build-arg REGISTRY_REDHAT=docker-private.nexus.local.leven.dev
    --build-arg REGISTRY_REDHAT=registry.your.domain
```
The `REGISTRY_DOCKERHUB` variable hold the url to the docker hub registry. The default value is docker.io, which is the official docker hub registry url. Your proxy should provide access to the official alpine image as that's the one used by this container.

The `REGISTRY_REDHAT` variable holds the url to the redhat UBI image repository. UBI is free to use anmd the official registry at registry.access.redhat.com can be freely used without any authentication. You can either use a proxy that offers access to the ubi8/ubi-micro package through `registry.access.redhat.com`, or (probably only if you have it already setup) use the redhat registry of the [redhat certified container catalog](https://catalog.redhat.com/) `registry.redhat.io`, which requires a free redhat developer account.

> Please note that custom registries are not required. Also you can either use no private registry at all, just one for any of both registries, or both. They can also both lay on the same URL but must be seperately specified.

## Contributions
Feel free to contribute in any way you want. Every help is appreciated. Adding new features like other CA servers should be first discussed in an issue to avoid possible missunderstandings. Asking for help is also really appreated! Just ask!

## License
[This project is licensed under MIT](#License) wich means that you can use it for anything you want to, but it'd be nice if you add a reference to it's original copyright holder and include it's license inside of your software in any way. Thank you!
