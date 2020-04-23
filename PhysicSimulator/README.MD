### Physic Simulador
O programa escrito em processing pode simular até 4 tipos de força, são eles:
```
IMPULSE_OBJECT (Impulsivo)
ATTRACT_FIELD (Atrativo de Campo)
REPULSE_FIELD (Repulsivo de Campo - Gravitacional)
PERMANENT_OBJECT (Força permanente) 
Para utilizar o simulador, inicie criando uma particula
```
classParticle p1 = new classParticle(particlePosition, new PVector(v*1.5f, 0.0f), particle_mass);
```
```
classParticle(PVector r0_position, PVector r0_velocity, float r0_mass, String r0_name)
classParticle(PVector r0_position, PVector r0_velocity, float r0_mass)
classParticle(PVector r0_position, PVector r0_velocity)
```
Agora escolha o modo de força (Campo ou Objeto)

para usar a força no objeto, utilize

Ex: 
```
typeForceObject _tfo1 = new typeForceField(enumForce.ATTRACT_FIELD, sunPosition, sun_mass);
```

Caso queira de campo:

```
typeForceObject(enumForce type, PVector force, float t_m_impulse)
typeForceObject(enumForce type, PVector force)
```
