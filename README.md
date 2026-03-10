<div align="center">
  <a href="http://tianshou.readthedocs.io"><img width="300px" height="auto" src="https://github.com/thu-ml/tianshou/raw/master/docs/_static/images/tianshou-logo.png"></a>
</div>

---

[![PyPI](https://img.shields.io/pypi/v/tianshou)](https://pypi.org/project/tianshou/)
[![CI](https://github.com/thu-ml/tianshou/actions/workflows/ci.yml/badge.svg)](https://github.com/thu-ml/tianshou/actions)
[![GitHub license](https://img.shields.io/github/license/thu-ml/tianshou)](https://github.com/thu-ml/tianshou/blob/master/LICENSE)

**Tianshou** is a reinforcement learning library based on pure PyTorch and [Gymnasium](http://github.com/Farama-Foundation/Gymnasium).

Key features:
- Modular low-level interfaces for RL researchers
- Convenient high-level APIs for applications
- Supports on-policy, off-policy, offline RL, MARL, and model-based algorithms
- High-performance with type safety

## Installation

```bash
git clone git@github.com:thu-ml/tianshou.git
cd tianshou
uv sync
```

For development dependencies:
```bash
uv sync --dev
```

## Quick Start

High-level API example with DQN on CartPole:

```python
from tianshou.highlevel.config import OffPolicyTrainingConfig
from tianshou.highlevel.env import EnvFactoryRegistered, VectorEnvType
from tianshou.highlevel.experiment import DQNExperimentBuilder, ExperimentConfig
from tianshou.highlevel.params.algorithm_params import DQNParams

experiment = (
    DQNExperimentBuilder(
        EnvFactoryRegistered(
            task="CartPole-v1",
            venv_type=VectorEnvType.DUMMY,
            training_seed=0,
            test_seed=10,
        ),
        ExperimentConfig(persistence_enabled=False),
        OffPolicyTrainingConfig(
            max_epochs=10,
            epoch_num_steps=10000,
            batch_size=64,
            num_training_envs=10,
            num_test_envs=100,
            buffer_size=20000,
        ),
    )
    .with_dqn_params(
        DQNParams(
            lr=1e-3,
            gamma=0.9,
            n_step_return_horizon=3,
            target_update_freq=320,
            eps_training=0.3,
            eps_inference=0.0,
        ),
    )
    .with_model_factory_default(hidden_sizes=(64, 64))
    .build()
)
experiment.run()
```

Find more examples in `test/` and `examples/` folders.

## Documentation

API documentation available in `docs/01_user_guide/`.

## Citing

```latex
@article{tianshou,
  author  = {Jiayi Weng and Huayu Chen and Dong Yan and Kaichao You and Alexis Duburcq and Minghao Zhang and Yi Su and Hang Su and Jun Zhu},
  title   = {Tianshou: A Highly Modularized Deep Reinforcement Learning Library},
  journal = {Journal of Machine Learning Research},
  year    = {2022},
  volume  = {23},
  number  = {267},
  pages   = {1--6},
  url     = {http://jmlr.org/papers/v23/21-1127.html}
}
```
