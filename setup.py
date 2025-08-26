from setuptools import setup,find_packages

with open("rquirements.txt") as f:
    requirements = f.read().splitlines()

setup(
    name="ANIME-RECOMMENDER",
    version="0.1",
    author="iblamepiyush",
    packages=find_packages(),
    install_requires = requirements,
)