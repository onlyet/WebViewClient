#pragma once

template<typename DerivedClass>
struct Singleton
{
	static DerivedClass& Instance() {
		static DerivedClass m_instance;
		return m_instance;
	}
protected:
	Singleton() = default;
	~Singleton() = default;
private:
	Singleton(const Singleton&) = delete;
	Singleton& operator=(Singleton&) = delete;
};

