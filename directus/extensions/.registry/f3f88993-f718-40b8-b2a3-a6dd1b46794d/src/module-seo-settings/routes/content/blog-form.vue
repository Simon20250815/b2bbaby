<template>
    <private-view smallHeader :title="isEdit ? 'Edit Blog' : 'Create Blog'">
        <template #title>
            <div>
                <h1 class="font-semibold text-lg text-slate-900">{{ isEdit ? 'Edit Blog' : 'Create Blog' }}</h1>
                <div class="text-sm">{{ isEdit ? 'Modify blog post details' : 'Add a new blog post' }}</div>
            </div>
        </template>
        <template #actions>
            <v-button
                v-tooltip.bottom="Save"
                @click="onSave"
                rounded
                icon
                :disabled="saving || loading"
                :loading="saving"
            >
                <v-icon name="check"></v-icon>
            </v-button>
        </template>
        <template #navigation>
            <navigator />
        </template>
        <div class="py-6 px-7.5 max-w-5xl">
            <div class="grid gap-6">
                <div class="bg-white rounded-xl border border-slate-200 shadow-sm p-6">
                    <h2 class="text-sm font-semibold text-slate-700 uppercase tracking-wider mb-4">Basic Information</h2>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div class="space-y-2">
                            <label class="block text-sm font-medium text-slate-700">Title (English)</label>
                            <input 
                                v-model="formData.title" 
                                type="text" 
                                placeholder="Enter blog title"
                                class="w-full px-4 py-2.5 border border-slate-200 rounded-lg focus:outline-none focus:border-primary focus:ring-2 focus:ring-primary/20"
                            />
                        </div>
                        <div class="space-y-2">
                            <label class="block text-sm font-medium text-slate-700">Slug</label>
                            <input 
                                v-model="formData.slug" 
                                type="text" 
                                placeholder="URL-friendly identifier"
                                class="w-full px-4 py-2.5 border border-slate-200 rounded-lg focus:outline-none focus:border-primary focus:ring-2 focus:ring-primary/20"
                            />
                        </div>
                        <div class="space-y-2">
                            <label class="block text-sm font-medium text-slate-700">Category</label>
                            <select 
                                v-model="formData.category"
                                class="w-full px-4 py-2.5 border border-slate-200 rounded-lg focus:outline-none focus:border-primary bg-white"
                            >
                                <option value="">Select category</option>
                                <option value="certification">Certification</option>
                                <option value="purchasing">Purchasing</option>
                                <option value="product">Product</option>
                                <option value="general">General</option>
                            </select>
                        </div>
                        <div class="space-y-2">
                            <label class="block text-sm font-medium text-slate-700">Author</label>
                            <input 
                                v-model="formData.author" 
                                type="text" 
                                placeholder="Author name"
                                class="w-full px-4 py-2.5 border border-slate-200 rounded-lg focus:outline-none focus:border-primary focus:ring-2 focus:ring-primary/20"
                            />
                        </div>
                    </div>
                </div>

                <div class="bg-white rounded-xl border border-slate-200 shadow-sm p-6">
                    <h2 class="text-sm font-semibold text-slate-700 uppercase tracking-wider mb-4">Content</h2>
                    <div class="space-y-4">
                        <div class="space-y-2">
                            <label class="block text-sm font-medium text-slate-700">Excerpt (English)</label>
                            <textarea 
                                v-model="formData.excerpt" 
                                rows="2"
                                placeholder="Brief summary of the post"
                                class="w-full px-4 py-2.5 border border-slate-200 rounded-lg focus:outline-none focus:border-primary focus:ring-2 focus:ring-primary/20 resize-none"
                            ></textarea>
                        </div>
                        <div class="space-y-2">
                            <label class="block text-sm font-medium text-slate-700">Content (English)</label>
                            <textarea 
                                v-model="formData.content" 
                                rows="8"
                                placeholder="Enter blog content"
                                class="w-full px-4 py-2.5 border border-slate-200 rounded-lg focus:outline-none focus:border-primary focus:ring-2 focus:ring-primary/20 resize-none"
                            ></textarea>
                        </div>
                        <div class="space-y-2">
                            <label class="block text-sm font-medium text-slate-700">Content (Chinese)</label>
                            <textarea 
                                v-model="formData.content_en" 
                                rows="8"
                                placeholder="中文内容"
                                class="w-full px-4 py-2.5 border border-slate-200 rounded-lg focus:outline-none focus:border-primary focus:ring-2 focus:ring-primary/20 resize-none"
                            ></textarea>
                        </div>
                    </div>
                </div>

                <div class="bg-white rounded-xl border border-slate-200 shadow-sm p-6">
                    <h2 class="text-sm font-semibold text-slate-700 uppercase tracking-wider mb-4">Tags</h2>
                    <div class="space-y-3">
                        <div class="flex flex-wrap gap-2">
                            <span 
                                v-for="(tag, index) in formData.tags" 
                                :key="index"
                                class="inline-flex items-center gap-1 px-3 py-1.5 bg-blue-50 text-blue-700 rounded-full text-sm"
                            >
                                {{ tag }}
                                <button @click="removeTag(index)" class="hover:text-blue-900">
                                    <v-icon name="close" class="w-4 h-4" />
                                </button>
                            </span>
                        </div>
                        <div class="flex gap-2">
                            <input 
                                v-model="newTag" 
                                type="text" 
                                placeholder="Add tag"
                                class="flex-1 px-4 py-2.5 border border-slate-200 rounded-lg focus:outline-none focus:border-primary focus:ring-2 focus:ring-primary/20"
                                @keyup.enter="addTag"
                            />
                            <v-button secondary @click="addTag">Add</v-button>
                        </div>
                    </div>
                </div>

                <div class="bg-white rounded-xl border border-slate-200 shadow-sm p-6">
                    <h2 class="text-sm font-semibold text-slate-700 uppercase tracking-wider mb-4">Publication</h2>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div class="space-y-2">
                            <label class="block text-sm font-medium text-slate-700">Publish Date</label>
                            <input 
                                v-model="formData.date_published" 
                                type="date"
                                class="w-full px-4 py-2.5 border border-slate-200 rounded-lg focus:outline-none focus:border-primary focus:ring-2 focus:ring-primary/20"
                            />
                        </div>
                        <div class="space-y-2">
                            <label class="block text-sm font-medium text-slate-700">Status</label>
                            <div class="flex items-center gap-4">
                                <label class="flex items-center gap-2 cursor-pointer">
                                    <input 
                                        v-model="formData.status" 
                                        type="radio" 
                                        value="published"
                                        class="w-4 h-4 text-primary"
                                    />
                                    <span class="text-sm text-slate-700">Published</span>
                                </label>
                                <label class="flex items-center gap-2 cursor-pointer">
                                    <input 
                                        v-model="formData.status" 
                                        type="radio" 
                                        value="draft"
                                        class="w-4 h-4 text-primary"
                                    />
                                    <span class="text-sm text-slate-700">Draft</span>
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </private-view>
</template>

<script setup lang="ts">
import { ref, reactive, computed, onMounted } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import { useApi, useStores } from '@directus/extensions-sdk';
import Navigator from '../../components/navigator/index.vue';

const route = useRoute();
const router = useRouter();
const api = useApi();
const { useNotificationsStore } = useStores();
const notify = useNotificationsStore();

const isEdit = computed(() => !!route.params.id);
const loading = ref(false);
const saving = ref(false);
const newTag = ref('');

const formData = reactive({
    title: '',
    slug: '',
    category: '',
    author: '',
    excerpt: '',
    content: '',
    content_en: '',
    tags: [] as string[],
    date_published: new Date().toISOString().split('T')[0],
    status: 'draft'
});

function addTag() {
    if (newTag.value.trim()) {
        formData.tags.push(newTag.value.trim());
        newTag.value = '';
    }
}

function removeTag(index: number) {
    formData.tags.splice(index, 1);
}

async function loadBlog() {
    if (!isEdit.value) return;
    
    loading.value = true;
    try {
        const response = await api.get(`/items/blogs/${route.params.id}`);
        const data = response.data.data;
        formData.title = data.title || '';
        formData.slug = data.slug || '';
        formData.category = data.category || '';
        formData.author = data.author || '';
        formData.excerpt = data.excerpt || '';
        formData.content = data.content || '';
        formData.content_en = data.content_en || '';
        formData.tags = data.tags || [];
        formData.date_published = data.date_published ? data.date_published.split('T')[0] : new Date().toISOString().split('T')[0];
        formData.status = data.status || 'draft';
    } catch (error) {
        console.error('Failed to load blog:', error);
        notify.add({ title: 'Error loading blog', type: 'error' });
    }
    loading.value = false;
}

async function onSave() {
    saving.value = true;
    try {
        const payload = {
            ...formData,
            slug: formData.slug || formData.title.toLowerCase().replace(/\s+/g, '-')
        };

        if (isEdit.value) {
            await api.patch(`/items/blogs/${route.params.id}`, payload);
            notify.add({ title: 'Blog updated successfully' });
        } else {
            await api.post('/items/blogs', payload);
            notify.add({ title: 'Blog created successfully' });
        }
        
        router.push('/seo-settings/content/blogs');
    } catch (error) {
        console.error('Failed to save blog:', error);
        notify.add({ title: 'Error saving blog', type: 'error' });
    }
    saving.value = false;
}

onMounted(() => {
    loadBlog();
});
</script>