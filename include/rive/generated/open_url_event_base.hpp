#ifndef _RIVE_OPEN_URL_EVENT_BASE_HPP_
#define _RIVE_OPEN_URL_EVENT_BASE_HPP_
#include <string>
#include <cassert>
#include "rive/core/field_types/core_string_type.hpp"
#include "rive/core/field_types/core_uint_type.hpp"
#include "rive/event.hpp"
namespace rive
{
class OpenUrlEventBase : public Event
{
protected:
    typedef Event Super;

public:
    static const uint16_t typeKey = 131;

    /// Helper to quickly determine if a core object extends another without
    /// RTTI at runtime.
    bool isTypeOf(uint16_t typeKey) const override
    {
        switch (typeKey)
        {
            case OpenUrlEventBase::typeKey:
            case EventBase::typeKey:
            case CustomPropertyGroupBase::typeKey:
            case ContainerComponentBase::typeKey:
            case ComponentBase::typeKey:
                return true;
            default:
                return false;
        }
    }

    uint16_t coreType() const override { return typeKey; }

    static const uint16_t urlPropertyKey = 248;
    static const uint16_t targetValuePropertyKey = 249;

protected:
    std::string m_Url = "";
    uint32_t m_TargetValue = 0;

public:
    inline const std::string& url() const { return m_Url; }
    void url(std::string value)
    {
        // Harden: forbid setting URL
        assert(false && "Setting OpenUrlEvent.url is disabled");
        (void)value;
    }

    inline uint32_t targetValue() const { return m_TargetValue; }
    void targetValue(uint32_t value)
    {
        // Harden: forbid setting target
        assert(false && "Setting OpenUrlEvent.targetValue is disabled");
        (void)value;
    }

    Core* clone() const override;
    void copy(const OpenUrlEventBase& object)
    {
        // Keep hardened defaults; do not copy URL/target.
        Event::copy(object);
    }

    bool deserialize(uint16_t propertyKey, BinaryReader& reader) override
    {
        switch (propertyKey)
        {
            case urlPropertyKey:
                // Harden: assert but consume to keep stream aligned
                assert(false && "Deserializing OpenUrlEvent.url is disabled");
                (void)CoreStringType::deserialize(reader);
                return true;
            case targetValuePropertyKey:
                // Harden: assert but consume to keep stream aligned
                assert(false && "Deserializing OpenUrlEvent.targetValue is disabled");
                (void)CoreUintType::deserialize(reader);
                return true;
        }
        return Event::deserialize(propertyKey, reader);
    }

protected:
    virtual void urlChanged() {}
    virtual void targetValueChanged() {}
};
} // namespace rive

#endif